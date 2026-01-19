import { GoogleGenerativeAI } from "@google/genai";
import { z } from "zod";
import { zodToJsonSchema } from "zod-to-json-schema";

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY!);

const ResponseSchema = z.object({
  sentiment: z.enum(["positive", "negative", "neutral"]),
  intensity: z.number().describe("Scale of 1-10"),
  reasoning: z.string(),
});

async function main() {
  const model = genAI.getGenerativeModel({
    model: "gemini-1.5-flash",
    generationConfig: {
      responseMimeType: "application/json",
      responseSchema: zodToJsonSchema(ResponseSchema as any),
    },
  });

  const prompt =
    "Analyze the sentiment of this text: 'Bun is incredibly fast, but I'm still learning the new APIs.'";
  const result = await model.generateContent(prompt);

  const parsed = ResponseSchema.parse(JSON.parse(result.response.text()));
  console.log("Sentiment Analysis:", parsed);
}

main();
