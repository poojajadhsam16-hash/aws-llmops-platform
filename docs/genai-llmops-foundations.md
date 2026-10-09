# GenAI and LLMOps Foundations

## Day 3 — October 10, 2026

## What Is an LLM?

A Large Language Model processes text and generates
responses based on learned language patterns and its input.

## Important Concepts

### Tokens
Pieces of text processed by a language model.

### Context Window
The amount of information a model can process in
a single interaction, subject to model limits.

### Prompt Engineering
Designing instructions and input to guide model responses.

### Temperature
A generation parameter that influences response variability.

### Hallucination
Generated information that is false, fabricated,
or unsupported by the available evidence.

## How RAG Helps

RAG retrieves relevant information from a knowledge
base and supplies it to the LLM as context.

It can improve grounding but does not guarantee
that every answer will be correct.

## LLMOps Lifecycle

1. Develop the application.
2. Version code and prompts.
3. Test and build the application.
4. Deploy the application.
5. Monitor logs, latency, errors and costs.
6. Evaluate response quality and improve the system.

## Security Considerations

- Never commit API keys or AWS credentials.
- Avoid logging sensitive user information.
- Use least-privilege permissions.
- Validate model outputs where necessary.
- Evaluate responses against trusted information.

## Hands-on Work

- Created an AWS support assistant prompt.
- Practised a structured EC2 troubleshooting scenario.
- Documented LLM concepts and the LLMOps lifecycle.

## Interview Summary

LLMOps applies operational practices to LLM-powered
applications, including versioning, deployment,
monitoring, evaluation, security and cost management.

