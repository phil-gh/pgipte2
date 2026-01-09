import inquirer from "inquirer";
import { configManager } from "./config.js";

/**
 * Show interactive settings dialog
 */
export async function showSettings(): Promise<void> {
  console.log("\n=== PoE Price Settings ===\n");

  const current = configManager.getAll();
  console.log(`Current settings:`);
  console.log(`  Reduction Percent: ${current.percent}%`);
  console.log(`  Conversion Rate: ${current.rate}`);
  console.log(`  UI Delay: ${current.uiDelayMs}ms`);
  console.log("");

  const answers = await inquirer.prompt([
    {
      type: "number",
      name: "percent",
      message: "Reduction Percent (1-99):",
      default: current.percent,
      validate: (value: number) => {
        if (value < 1 || value > 99) {
          return "Percentage must be between 1 and 99.js";
        }
        return true;
      },
    },
    {
      type: "number",
      name: "rate",
      message: "Conversion Rate (> 0):",
      default: current.rate,
      validate: (value: number) => {
        if (value <= 0) {
          return "Rate must be greater than 0.js";
        }
        return true;
      },
    },
    {
      type: "number",
      name: "uiDelayMs",
      message: "UI Delay in milliseconds (0-5000):",
      default: current.uiDelayMs,
      validate: (value: number) => {
        if (value < 0 || value > 5000) {
          return "UI delay must be between 0 and 5000 milliseconds";
        }
        return true;
      },
    },
  ]);

  try {
    configManager.setPercent(answers.percent);
    configManager.setRate(answers.rate);
    configManager.setUiDelayMs(answers.uiDelayMs);
    console.log("\n✓ Settings saved successfully!\n");
  } catch (error) {
    console.error("Failed to save settings:", error);
  }
}
