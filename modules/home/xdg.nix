let
  pdf = ["okular.desktop"];
  pdf_app = ["okularApplication_pdf.desktop"];
  browser = ["vivaldi.desktop"];
  associations = {
    "text/pdf" = pdf;
    "application/pdf" = pdf_app;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/chrome" = browser;
    "text/html" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;
  };
in {
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = associations;
    associations.added = associations;
  };
}
