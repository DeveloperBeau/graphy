import banner from './banner.js';
import layout from './layout.js';

function printReport(title) {
  console.log(banner.boxed(title));
}

function printPage(text, cols, themeName) {
  console.log(layout.renderPage(text, cols, themeName));
}

export default { printReport, printPage };
