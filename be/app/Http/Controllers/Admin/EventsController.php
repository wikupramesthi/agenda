<?php

namespace App\Http\Controllers\Admin;

/**
 * Wrapper agar route lama /events tetap jalan tapi logic terpusat di AgendaController (rapih, tidak duplikat).
 * Semua method diwarisi dari AgendaController yang sudah rapih & anti-bug.
 * @deprecated gunakan AgendaController
 */
class EventsController extends AgendaController
{
}
