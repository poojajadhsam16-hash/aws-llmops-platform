import json
import os
import urllib.error
import urllib.request
from pathlib import Path

from fastapi import FastAPI, HTTPException, Query

app = FastAPI(
    title="AWS LLMOps Platform",
    version="1.0.0",
    description="Document retrieval and AI question-answering API",
)

# Locate the knowledge file from the project root.
DOC_PATH = (
    Path(__file__).resolve().parent.parent
    / "docs"
    / "knowledge.txt"
)

# Docker Compose can override this environment variable.
# Ollama's native chat API uses /api/chat.
OLLAMA_URL = os.getenv(
    "OLLAMA_URL",
    "http://host.docker.internal:11434/api/chat",
)
OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "llama3.2:1b")


def retrieve_context(question: str) -> str:
    """Retrieve the most relevant line from the local knowledge file."""
    if not DOC_PATH.exists():
        raise HTTPException(
            status_code=500,
            detail=f"Knowledge file not found: {DOC_PATH}",
        )

    lines = [
        line.strip()
        for line in DOC_PATH.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]

    if not lines:
        return "No knowledge documents are available."

    # Lightweight keyword-overlap retrieval; no extra ML dependency needed.
    question_words = set(question.lower().split())

    def score(line: str) -> int:
        line_words = set(
            line.lower().replace("/", " ").replace(".", " ").split()
        )
        return len(question_words & line_words)

    best_line = max(lines, key=score)
    return best_line


@app.get("/")
def home():
    return {
        "message": "AWS LLMOps Platform is running",
        "version": "1.0.0",
    }


@app.get("/health")
def health():
    return {"status": "healthy"}


@app.get("/rag")
def rag(
    question: str = Query(..., min_length=1),
):
    context = retrieve_context(question)
    return {
        "question": question,
        "retrieved_context": context,
    }


@app.get("/ask")
def ask(
    question: str = Query(..., min_length=1),
):
    context = retrieve_context(question)

    prompt = (
        "You are an assistant for the AWS LLMOps Platform. "
        "Answer using the supplied context. If the context does not "
        "contain the answer, clearly say that the information is not "
        "available in the knowledge base.\n\n"
        f"Context:\n{context}\n\n"
        f"Question: {question}"
    )

    payload = {
        "model": OLLAMA_MODEL,
        "messages": [
            {
                "role": "user",
                "content": prompt,
            }
        ],
        "stream": False,
    }

    request = urllib.request.Request(
        OLLAMA_URL,
        data=json.dumps(payload).encode("utf-8"),
        headers={"Content-Type": "application/json"},
        method="POST",
    )

    try:
        with urllib.request.urlopen(request, timeout=180) as response:
            result = json.loads(response.read().decode("utf-8"))

        answer = result.get("message", {}).get("content", "")
        if not answer:
            raise HTTPException(
                status_code=502,
                detail="Ollama returned an empty answer.",
            )

        return {
            "question": question,
            "retrieved_context": context,
            "answer": answer,
            "model": OLLAMA_MODEL,
        }

    except urllib.error.HTTPError as exc:
        error_body = exc.read().decode("utf-8", errors="replace")
        raise HTTPException(
            status_code=502,
            detail=f"Ollama HTTP error {exc.code}: {error_body}",
        ) from exc

    except (urllib.error.URLError, TimeoutError) as exc:
        raise HTTPException(
            status_code=503,
            detail=(
                "Cannot connect to Ollama. Check that Ollama is running, "
                "the model is available, and OLLAMA_URL is correct. "
                f"Configured URL: {OLLAMA_URL}"
            ),
        ) from exc

    except json.JSONDecodeError as exc:
        raise HTTPException(
            status_code=502,
            detail="Ollama returned an invalid JSON response.",
        ) from exc


