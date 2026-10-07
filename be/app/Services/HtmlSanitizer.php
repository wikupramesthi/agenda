<?php

namespace App\Services;

/**
 * Ringkas sanitasi HTML dari Summernote/Quill.
 * Tanpa mews/purifier, cukup hilangkan <script>, event handler on*, javascript: url.
 * Cukup untuk urgent, bisa diganti HTMLPurifier nanti tanpa ubah caller.
 */
class HtmlSanitizer
{
    public static function clean(?string $html): ?string
    {
        if ($html === null || $html === '') {
            return $html;
        }

        // Hapus <script>...</script> dan <style>...</style>
        $html = preg_replace('#<script\b[^>]*>(.*?)</script>#is', '', $html);
        $html = preg_replace('#<style\b[^>]*>(.*?)</style>#is', '', $html);

        // Hapus event handler on*="..."  (onclick, onerror etc)
        $html = preg_replace('#\s+on\w+\s*=\s*("[^"]*"|\'[^\']*\'|[^\s>]+)#i', '', $html);

        // Hapus javascript: di href/src
        $html = preg_replace('#\s+(href|src)\s*=\s*("[^"]*javascript:[^"]*"|\'[^\']*javascript:[^\']*\'|javascript:[^\s>]+)#i', ' $1="#"', $html);

        // Hapus iframe dengan src external berbahaya (biarkan youtube/google trusted saja jika perlu, default hapus)
        // Untuk urgent, biarkan iframe tapi pakai sandbox? sementara strip iframe.
        // $html = preg_replace('#<iframe\b[^>]*>(.*?)</iframe>#is', '', $html);

        return $html;
    }
}
