<?php

require 'aws.phar';

use Aws\ElasticTranscoder\ElasticTranscoderClient;

$aws_elastictranscoder_pipeline  = '';
$aws_elastictranscoder_preset_sd = '';
$aws_elastictranscoder_preset_hd = '';

$aws_iam_access_key              = '';
$aws_iam_access_secret           = '';
$aws_region                      = '';

$elasticTranscoder = ElasticTranscoderClient::factory([
    'key'    => $aws_iam_access_key,
    'secret' => $aws_iam_access_secret,
    'region' => $aws_region ]);

$id = time();

$src_path = 'uploaded/';
$src_file = 'uservideo.mp4';

$dst_path = "encoded/$src_file/$id/";

$jobSetting = [

    'PipelineId' => $aws_elastictranscoder_pipeline,

    'Input' => [
        'Key' => $src_path.$src_file,
        'FrameRate' => 'auto',
        'Resolution' => 'auto',
        'AspectRatio' => 'auto',
        'Interlaced' => 'auto',
        'Container' => 'auto',
    ],

    'OutputKeyPrefix' => $dst_path,

    'Outputs' => [
        [
            'Key' => 'sd/encoded',
            'Rotate' => 'auto',
            'PresetId' => $aws_elastictranscoder_preset_sd,
            'ThumbnailPattern' => 'sd/encoded_{resolution}_{count}',
            'SegmentDuration' => 10,
        ],
        [
            'Key' => 'hd/encoded',
            'Rotate' => 'auto',
            'PresetId' => $aws_elastictranscoder_preset_hd,
            'ThumbnailPattern' => 'hd/encoded_{resolution}_{count}',
            'SegmentDuration' => 10,
        ],
    ],

    'Playlists' => [
        [
            "Format" => "HLSv3",
            "Name" => "encoded",
            "OutputKeys" => [
                'sd/encoded',
                'hd/encoded',
            ]
        ]
    ],

    'UserMetadata' => [
        'Key' => 'Value',
    ],

];

$job = $elasticTranscoder->createJob($jobSetting);

// get the job data as array
$jobData = $job->get('Job');

// you can save the job ID somewhere, so you can check the status from time to time.
$jobId = $jobData['Id'];

// Checking a jobs status
$response = $elasticTranscoder->readJob( [ 'Id' => $jobId ] );

$jobData = $response->get('Job');

if ($jobData['Status'] !== 'progressing' && $jobData['Status'] !== 'submitted')
{
    print_r($jobData);
}
