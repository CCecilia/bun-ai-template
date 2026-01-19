import ollama from "ollama";
import { z } from "zod";
import { zodToJsonSchema } from "zod-to-json-schema";

const ResponsSchema = z.object({
  action: z.string().describe("The primary action to take"),
  parameters: z
    .object(z.string())
    .describe("Necessary arguments for the action"),
  priority: z.number(),
});

async function main() {
  const schema = zodToJsonSchema(ResponsSchema as any);

  const response = await ollama.chat({
    model: "llama3.1", // or any model supporting tools/JSON
    messages: [
      {
        role: "user",
        content: "I need to schedule a meeting with Bob at 3pm.",
      },
    ],
    format: schema as any,
    stream: false,
  });

  const content = JSON.parse(response.message.content);
  const validated = ResponsSchema.parse(content);

  console.log("Ollama Action:", validated);
}

main();
