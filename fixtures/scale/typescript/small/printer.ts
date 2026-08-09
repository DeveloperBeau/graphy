import { Banner } from './banner';
import { Layout } from './layout';

export class Printer {
  static printReport(title: string): void {
    console.log(Banner.boxed(title));
  }

  static printPage(text: string, cols: number, themeName: string): void {
    console.log(Layout.renderPage(text, cols, themeName));
  }
}
