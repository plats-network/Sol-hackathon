@extends('web.layouts.event_app')

@section('content')
    @php
        $userId = auth()->user()->id;
        $email = auth()->user()->email;
        $userCode = new App\Models\Event\UserCode();
    @endphp

    <style type="text/css">
        .timeline-container ul.tl li {
            list-style: none;
            margin: auto;
            min-height: 50px;
            border-left: 1px solid #86D6FF;
            padding: 0 0 15px 25px;
            position: relative;
            display: flex;
            flex-direction: row;
        }

        #laravel-notify {
            z-index: 1000;
            position: absolute;
        }

        .fs-25 {
            font-size: 25px;
            color: #228b22;
        }

        .pp {
            padding-left: 20px;
            line-height: 20px !important;
            color: #000 !important;
        }

        .aaa {
            background-color: #fff8ea;
            padding: 7px 10px;
            border-radius: 10px;
            margin-bottom: 15px;
            color: #000;
            line-height: 20px;
            font-size: 15px;
            border: 2px solid #fab501;
        }

        #laravel-notify {
            position: absolute;
            z-index: 99999;
        }
    </style>

    <style type="text/css">
        .tab-job {
            justify-content: center;
            order-bottom: none;
        }

        .nav-link {
            border: 2px solid #177FE2;
        }

        .b1 {
            border-radius: 10px 0 0 10px;
        }

        .b2 {
            border-radius: 0px 10px 10px 0;
        }

        .active-job {
            background-color: #177FE2;
            color: #fff;
        }

        .ac-color {
            color: #258CC7 !important;
            font-weight: bold !important;
        }

        .desc-prize {
            background-color: #fff8ea;
            padding: 7px 10px;
            border-radius: 10px;
            margin-bottom: 15px;
            color: #000;
            line-height: 20px;
            font-size: 15px;
            border: 2px solid #fab501;
        }

        #laravel-notify {
            position: absolute;
            z-index: 99999;
        }
    </style>

    <section class="travel" id="flagU" data-flag="{{$flagU}}">
        <div class="container">
            <div class="travel-content">
                <div class="info">
                    <table class="table">
                        <tr>
                            <td>
                                @if (Str::contains($email, 'guest'))
                                    <p class="text-danger">Please add email.</p>
                                @else
                                    {{$email}}
                                @endif
                            </td>
                            <td class="text-center">
                                <a id="editInfo" href="#"
                                   style="color: red;">{{Str::contains($email, 'guest') ? 'Add' : 'Edit'}}</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="event-info">
                    <h3 style="padding-bottom: 0;">{{$event->name}}</h3>
                    {{-- <img src="{{$event->banner_url}}" alt="{{$event->name}}"> --}}
                    <div class="text-center" style="margin: 5px auto;">
                        <img style="width: 100%;" src="{{$event->banner_url}}" alt="{{$event->name}}">
                    </div>
                </div>

                <div class="row">
                    <div class="text-center">
                        <img
                            src="data:image/png;base64, {!! $qrCode !!}"
                            alt="QR Code" style="max-width: 400px;">
                    </div>
                </div>
            </div>
        </div>
    </section>

    @include('web.events._modal_nft', [
        'nft' => $nft,
        'url' => $url
    ])

    <div id="infoEditEmail" class="modal fade @if (Str::contains($email, 'guest')) show @endif" data-backdrop="static"
         data-keyboard="false">
        <style type="text/css">
            .text-danger, .error {
                color: red;
            }

            .btn--order {
                padding: 10px 30px;
                background: #3EA2FF;
                color: #fff;
                text-align: right;
            }
        </style>

        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" style="font-size: 25px; text-align: center;">Register for Event Check-in</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form id="infoForm" method="POST" action="{{route('web.editEmail')}}">
                        @csrf
                        <input type="hidden" name="task_id" value="{{$event->id}}">
                        <div class="row" style="display: block;">
                            <div class="col-md-12">
                                <label class="form-label">Name <span class="text-danger">*</span></label>
                                <input
                                    type="text"
                                    class="form-control"
                                    name="name"
                                    required>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                <input
                                    type="text"
                                    class="form-control"
                                    name="email"
                                    required>
                            </div>
                        </div>
                        <div class="text-center" style="margin-top: 20px;">
                            <button type="submit" class="btn btn-primary btn--order">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection
