<?hh

require_once __DIR__.'/../vendor/autoload.php';
require_once __DIR__.'/../src/Vertex/Page.hh';

use Vertex\Page;

echo (new Page())->render();

