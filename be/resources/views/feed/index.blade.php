<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Posts</title>
</head>

<body>
    <h1>Blog Posts</h1>

    @if($posts && count($posts) > 0)
    <ul>
        @foreach($posts as $post)
        <li>
            <h2>{{ $post['title']['rendered'] }}</h2>
            <div>{!! $post['excerpt']['rendered'] !!}</div>

            @if(isset($post['image_url']))
            <img src="{{ $post['image_url'] }}" alt="{{ $post['title']['rendered'] }}" style="max-width: 100%; height: auto;">
            @endif

            <a href="{{ $post['link'] }}">Read more</a>
        </li>
        @endforeach
    </ul>
    @else
    <p>No posts found.</p>
    @endif
</body>

</html>