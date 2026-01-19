import OpenAI from "openai";
import { zodResponseFormat } from "openai/helpers/zod";
import { z } from "zod";

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

const ResponseSchema = z.object({
  summary: z.string().describe("A 2-sentence summary of the topic"),
  key_facts: z.array(z.string()).describe("3 interesting facts"),
  confidence_score: z.number().min(0).max(1),
});

async function main() {
  const completion = await openai.beta.chat.completions.parse({
    model: "gpt-4o-2024-08-06",
    messages: [
      { role: "system", content: "You are a research assistant." },
      {
        role: "user",
        content: "Tell me about the benefits of using Bun.js for AI.",
      },
    ],
    response_format: zodResponseFormat(ResponseSchema, "research"),
  });

  const result = completion.choices[0].message.parsed;
  console.log("Structured Response:", result);
}

main();
