<?hh

namespace Vertex;

use XHPUnsafeRenderable;
use Parsedown;

class MarkdownXHPWrapper implements XHPUnsafeRenderable {
  private string $html;

  public function __construct(string $markdownSource) {
    $this->html = (new Parsedown())->text($markdownSource);
  }

  public function toHTMLString(): string {
    return $this->html;
  }
}
