<!DOCTYPE html>
<html lang="en">
<head>
    <title>Ticket Event</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="author" content="Plats Network"/>
    <style type="text/css" media="screen">
        html {
            font-family: sans-serif;
            line-height: 1.15;
            margin: 0;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            text-align: left;
            background-color: #fff;
            font-size: 10px;
            margin: 36pt;
        }

        h4 {
            margin-top: 0;
            margin-bottom: 0.5rem;
        }

        p {
            margin-top: 0;
            margin-bottom: 1rem;
        }

        strong {
            font-weight: bolder;
        }

        img {
            vertical-align: middle;
            border-style: none;
        }

        table {
            border-collapse: collapse;
        }

        th {
            text-align: inherit;
        }

        h4, .h4 {
            margin-bottom: 0.5rem;
            font-weight: 500;
            line-height: 1.2;
        }

        h4, .h4 {
            font-size: 1.5rem;
        }

        .table {
            width: 100%;
            margin-bottom: 1rem;
            color: #212529;
        }

        .table th,
        .table td {
            padding: 0.75rem;
            vertical-align: top;
        }

        .table.table-items td {
            border-top: 1px solid #dee2e6;
        }

        .table thead th {
            vertical-align: bottom;
            border-bottom: 2px solid #dee2e6;
        }

        .mt-5 {
            margin-top: 3rem !important;
        }

        .pr-0,
        .px-0 {
            padding-right: 0 !important;
        }

        .pl-0,
        .px-0 {
            padding-left: 0 !important;
        }

        .text-right {
            text-align: right !important;
        }

        .text-center {
            text-align: center !important;
        }

        .text-uppercase {
            text-transform: uppercase !important;
        }
        * {
            font-family: "DejaVu Sans";
        }
        body, h1, h2, h3, h4, h5, h6, table, th, tr, td, p, div {
            line-height: 1.1;
        }
        .party-header {
            font-size: 1.5rem;
            font-weight: 400;
        }
        .total-amount {
            font-size: 12px;
            font-weight: 700;
        }
        .border-0 {
            border: none !important;
        }
        .cool-gray {
            color: #6B7280;
        }
    </style>
</head>


<body>

<table class="table mt-2">
    <tbody>
    <tr>
        <td class="border-0 pl-0" width="70%">
            <h4 class="text-uppercase">
                <strong>Event Ticket</strong>
            </h4>
        </td>
        <td class="border-0 pl-0">
            <h4 class="text-uppercase cool-gray">
                 <strong>success</strong>
            </h4>
            <p>Ticket ID: <strong>{{ $userTicket->id }}</strong></p>
            <p>Date: <strong>{{ $dateRegister }}</strong></p>
        </td>
    </tr>
    </tbody>
</table>

{{--Event Image--}}
<img src="{{ $event->banner_url }}" style="height: 300px; width: 300px" alt="Event Image" width="100%">

{{--Event Name --}}
<h1>Event: {{ $event->name }}</h1>
{{--Date, Location--}}
<h3>Date {{ $event->start_at }} {{ $event->end_at }}</h3>
<h3>Event management {{ $event->author?$event->author->name :'' }}</h3>
<h3>Location {{ $event->address }}</h3>

<h2>Event Check-In Information</h2>
{{--QR Code--}}
<img src="data:image/png;base64, {!! base64_encode(QrCode::format('png')->size(250)->generate($urlAnswers)) !!} ">
{{--Ticket ID--}}
<h3>Ticket ID: {{$userTicket->id}}</h3>
{{--Ticket Type--}}

<p>If you have any questions, please contact us at info@plats.network.</p>

</body>

</html>
