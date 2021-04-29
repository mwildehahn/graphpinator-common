namespace Graphpinator\Exception;

abstract class GraphpinatorBase extends \Exception implements \JsonSerializable
{
    public const MESSAGE = '';

    protected vec<string> $messageArgs = [];
    protected ?\Graphpinator\Common\Location $location = null;
    protected ?\Graphpinator\Common\Path $path = null;
    protected ?array $extensions = null;

    public function __construct()
    {
        parent::__construct(\sprintf(static::MESSAGE, ...$this->messageArgs));
    }

    public function setLocation(\Graphpinator\Common\Location $location) : static
    {
        $this->location = $location;

        return $this;
    }

    public function setPath(\Graphpinator\Common\Path $path) : static
    {
        $this->path = $path;

        return $this;
    }

    public function setExtensions(array $extensions) : static
    {
        $this->extensions = $extensions;

        return $this;
    }

    public static function notOutputableResponse() : dict<string, string>
    {
        return dict[
            'message' => 'Server responded with unknown error.',
        ];
    }

    final public function jsonSerialize() : dict<string, mixed>
    {
        if (!$this->isOutputable()) {
            return self::notOutputableResponse();
        }

        $result = [
            'message' => $this->getMessage(),
        ];

        if ($this->location instanceof \Graphpinator\Common\Location) {
            $result['locations'] = [$this->location];
        }

        if ($this->path instanceof \Graphpinator\Common\Path) {
            $result['path'] = $this->path;
        }

        if (\is_array($this->extensions)) {
            $result['extensions'] = $this->extensions;
        }

        return $result;
    }

    public function isOutputable() : bool
    {
        return false;
    }
}
