<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class UserMedical extends Model
{
    use HasUuids;

    protected $fillable = [
        'user_id',
<<<<<<< HEAD
        'title',
        'patient_name',
=======
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
        'checkup_date',
        'blood_type',
        'height',
        'weight',
        'blood_pressure',
        'allergies',
        'result',
        'next_checkup_date',
<<<<<<< HEAD
        'doctor_name',
        'doctor_contact',
        'facility_name',
        'facility_contact',
        'doctor_notes',
        'checklist_items',
    ];

    protected $casts = [
        'checkup_date'     => 'date',
        'next_checkup_date'=> 'date',
        'checklist_items'  => 'array',
=======
    ];

    protected $casts = [
        'checkup_date' => 'date',
        'next_checkup_date' => 'date',
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
