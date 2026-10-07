<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;
use App\Models\WebsiteMenuItem as WebsiteMenuItemModel;

class WebsiteMenuItem extends Component
{
    public WebsiteMenuItemModel $item;
    public int $depth;

    public function __construct(WebsiteMenuItemModel $item, int $depth = 0)
    {
        $this->item = $item;
        $this->depth = $depth;
    }

    public function render(): View|Closure|string
    {
        return view('components.website-menu-item', ['item' => $this->item, 'depth' => $this->depth]);
    }
}