<?php

namespace App\Models;

/**
 * Wrapper agar kode lama yang pakai Event tetap jalan.
 * Tabel sudah di-rename ke `agendas`, logic terpusat di Agenda (rapih).
 * @deprecated gunakan Agenda
 */
class Event extends Agenda
{
}
