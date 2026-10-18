from fastapi.testclient import TestClient
from unittest.mock import patch

from app.main import app

client = TestClient(app)


def test_home_endpoint():
    response = client.get("/")
    assert response.status_code == 200


def test_health_endpoint():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"


@patch("app.main.urllib.request.urlopen")
def test_ask_endpoint(mock_urlopen):
    mock_urlopen.return_value.__enter__.return_value.read.return_value = (
        b'{"model":"llama3.2:1b",'
        b'"message":{"role":"assistant","content":"Terraform provisions AWS infrastructure."},'
        b'"done":true}'
    )

    response = client.get(
        "/ask",
        params={"question": "What does Terraform do?"},
    )

    assert response.status_code == 200
    data = response.json()
    assert data["question"] == "What does Terraform do?"
    assert "answer" in data

