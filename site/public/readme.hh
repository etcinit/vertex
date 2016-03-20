<?hh

require_once __DIR__.'/../vendor/autoload.php';
require_once __DIR__.'/../src/Vertex/Page.hh';
require_once __DIR__.'/../src/Vertex/MarkdownXHPWrapper.hh';

use Vertex\Page;
use Vertex\MarkdownXHPWrapper;

class ReadmeGenerator {
  const string README_PATH = '/opt/vertex/README.md';

  public function generate(): XHPRoot {
    $page = new Page();
    $parser = new Parsedown();

    $page->setContent(
      <div class="row">
        <div class="columns">
          {new MarkdownXHPWrapper(file_get_contents(static::README_PATH))}
        </div>
      </div>
    );

    return $page->render();
  }
}

echo (new ReadmeGenerator())->generate();
