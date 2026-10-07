<?php

namespace App\Http\Controllers;

use GuzzleHttp\Client;
use Illuminate\Http\Request;

class FeedController extends Controller
{
    public function index()
    {
        $client = new Client();
        $response = $client->get('https://blog.rumahdewi.com/wp-json/wp/v2/posts?per_page=5');
        $posts = json_decode($response->getBody()->getContents(), true);

        // Ambil gambar untuk setiap post
        foreach ($posts as &$post) {
            if (isset($post['featured_media'])) {
                $mediaResponse = $client->get("https://blog.rumahdewi.com/wp-json/wp/v2/media/{$post['featured_media']}");
                $mediaData = json_decode($mediaResponse->getBody()->getContents(), true);
                $post['image_url'] = $mediaData['source_url'] ?? '';
            }
        }


        return view('feed.index', ['posts' => $posts]);
    }
}
