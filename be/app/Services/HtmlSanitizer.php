<?php

namespace App\Services;

/**
 * Sanitasi HTML dari editor (Summernote/dll) sebelum disimpan/ditampilkan.
 * Allowlist ketat: buang tag berbahaya (script/iframe/object/embed/form/
 * svg/math/link/meta/base), event handler on*, CSS inline, dan skema URL
 * berbahaya (javascript:/vbscript:/data: kecuali gambar seperlunya).
 */
class HtmlSanitizer
{
    public static function clean(?string $html): ?string
    {
        if ($html === null || $html === '') {
            return $html;
        }

        // Hapus tag berbahaya beserta isinya.
        $html = preg_replace('#<(script|style|iframe|object|embed|form|svg|math|link|meta|base|title|textarea)\b[^>]*>.*?</\1\s*>#is', '', $html);
        // Hapus tag berbahaya self-closing / tanpa pasangan.
        $html = preg_replace('#<(script|style|iframe|object|embed|form|svg|math|link|meta|base|title|input|button|select|option)\b[^>]*/?>#i', '', $html);

        // Hapus event handler on*="..." (onclick, onerror, onload, ...).
        $html = preg_replace('#\s+on\w+\s*=\s*("[^"]*"|\'[^\']*\'|[^\s>]+)#i', '', $html);

        // Hapus atribut style="..." (CSS bisa membawa url()/expression).
        $html = preg_replace('#\s+style\s*=\s*("[^"]*"|\'[^\']*\'|[^\s>]+)#i', '', $html);

        // Netralkan skema URL berbahaya di href/src/action/background.
        $html = preg_replace_callback(
            '#\s+(href|src|action|background|poster)\s*=\s*("([^"]*)"|\'([^\']*)\'|([^\s>]+))#i',
            function ($m) {
                $attr = strtolower($m[1]);
                $url = trim($m[3] ?? $m[4] ?? $m[5] ?? '');
                $lower = strtolower(ltrim($url));
                if (str_starts_with($lower, 'javascript:') || str_starts_with($lower, 'vbscript:')) {
                    return ' ' . $attr . '="#"';
                }
                if (str_starts_with($lower, 'data:') && ! preg_match('#^data:image/(png|jpeg|gif|webp);base64,#i', $lower)) {
                    return ' ' . $attr . '="#"';
                }
                return $m[0];
            },
            $html
        );

        return $html;
    }
}
