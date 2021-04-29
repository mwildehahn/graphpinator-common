namespace Graphpinator\Common;

final class Path implements \JsonSerializable
{
    use \Nette\SmartObject;

    private vec<string> $path;

    public function __construct(vec<string> $path = [])
    {
        $this->path = $path;
    }

    public function add(string $pathItem) : self
    {
        $this->path[] = $pathItem;

        return $this;
    }

    public function pop() : self
    {
        \array_pop($this->path);

        return $this;
    }

    public function jsonSerialize() : vec<string>
    {
        return $this->path;
    }
}
