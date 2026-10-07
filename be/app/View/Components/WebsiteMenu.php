<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;
use App\Models\WebsiteMenu as WebsiteMenuModel;

class WebsiteMenu extends Component
{
    public string $location;
    public ?string $menuSlug;

    public function __construct(string $location = 'header', ?string $menuSlug = null)
    {
        $this->location = $location;
        $this->menuSlug = $menuSlug;
    }

    public function render(): View|Closure|string
    {
        $query = WebsiteMenuModel::where('location', $this->location)
            ->where('status', true)
            ->with(['items' => function ($q) {
                $q->where('status', true)
                  ->whereNull('parent_id')
                  ->with('children')
                  ->orderBy('position');
            }])
            ->orderBy('position');

        if ($this->menuSlug) {
            $query->where('slug', $this->menuSlug);
        }

        $menus = $query->get();

        return view('components.website-menu', compact('menus', 'location'));
    }
}