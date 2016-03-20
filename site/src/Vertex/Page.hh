<?hh

namespace Vertex;

use XHPRoot;
use XHPChild;

class Page {
  protected ?XHPChild $content;

  public function __construct() {
    $this->content = $this->getDefaultContents();
  }

  protected function getDefaultContents(): XHPChild {
    return
      <div class="row column large-8">
        <div class="text-center pad-50-top">
          <div class="logo" />
          <h1>You have arrived!</h1>
        </div>
        <div>
          <p>
            If you are reading this, it means you have successfully downloaded
            (or built) the Vertex Docker image. Next: Try mounting a directory
            with a Hack/PHP project to <code>/var/www/vertex</code> or building
            your own image using Vertex as a base.
          </p>
        </div>
        <div class="text-center">
          <a class="button" href="/readme.hh">View documentation</a>
        </div>
        <div class="text-center">
          HHVM: {HHVM_VERSION}
        </div>
      </div>;
  }

  public function render(): XHPRoot {
    return (
            <html>
              {$this->renderHeader()}

              <body>{$this->content}</body>
            </html>
    );
  }

  protected function renderHeader(): XHPChild {
    $stylesheets = ImmVector {
      'https://cdn.jsdelivr.net/foundation/6.2.0/foundation.min.css',
      'https://fonts.googleapis.com/css?family=Ek+Mukta:400,800',
      '/css/style.css',
    };

    $children = (ImmVector {<title>Welcome to Vertex</title>})->concat(
      $stylesheets->map($href ==> <link rel="stylesheet" href={$href} />),
    );

    return <head>{$children}</head>;
  }

  public function setContent(XHPChild $content) {
    $this->content = $content;
  }
}
