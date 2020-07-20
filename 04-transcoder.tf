resource "aws_elastictranscoder_preset" "magicvideos_sd_preset" {
  container   = "ts"
  description = "magicvideos_sd_preset"
  name        = "magicvideos_sd_preset"

  audio {
    audio_packing_mode = "SingleTrack"
    codec              = "AAC"
    sample_rate        = 44100
    bit_rate           = 128
    channels           = 2
  }

  audio_codec_options {
    profile = "AAC-LC"
  }

  video {
    codec                = "H.264"
    keyframes_max_dist   = "90"
    fixed_gop            = "true"
    bit_rate             = "720"
    frame_rate           = "30"
    max_frame_rate       = ""
    max_width            = "640"
    max_height           = "360"
    sizing_policy        = "Fit"
    padding_policy       = "Pad"
    display_aspect_ratio = "auto"
  }

  video_codec_options = {
    Profile                  = "baseline"
    Level                    = "3"
    MaxReferenceFrames       = 3
    InterlacedMode           = "Progressive"
    ColorSpaceConversionMode = "None"
  }

  video_watermarks {
    id                = "default"
    max_width         = "100px"
    max_height        = "100px"
    sizing_policy     = "Fit"
    horizontal_align  = "Left"
    horizontal_offset = "10px"
    vertical_align    = "Top"
    vertical_offset   = "10px"
    opacity           = "100"
    target            = "Content"
  }

  thumbnails {
    format         = "jpg"
    interval       = 10
    max_width      = "320"
    max_height     = "180"
    padding_policy = "NoPad"
    sizing_policy  = "Stretch"
  }

}

resource "aws_elastictranscoder_preset" "magicvideos_hd_preset" {
  container   = "ts"
  description = "magicvideos_hd_preset"
  name        = "magicvideos_hd_preset"

  audio {
    audio_packing_mode = "SingleTrack"
    codec              = "AAC"
    sample_rate        = 44100
    bit_rate           = 128
    channels           = 2
  }

  audio_codec_options {
    profile = "AAC-LC"
  }

  video {
    codec                = "H.264"
    keyframes_max_dist   = "90"
    fixed_gop            = "true"
    bit_rate             = "2400"
    frame_rate           = "30"
    max_frame_rate       = ""
    max_width            = "1280"
    max_height           = "720"
    sizing_policy        = "Fit"
    padding_policy       = "Pad"
    display_aspect_ratio = "auto"
  }

  video_codec_options = {
    Profile                  = "baseline"
    Level                    = "3"
    MaxReferenceFrames       = 3
    InterlacedMode           = "Progressive"
    ColorSpaceConversionMode = "None"
  }

  video_watermarks {
    id                = "default"
    max_width         = "100px"
    max_height        = "100px"
    sizing_policy     = "Fit"
    horizontal_align  = "Left"
    horizontal_offset = "10px"
    vertical_align    = "Top"
    vertical_offset   = "10px"
    opacity           = "100"
    target            = "Content"
  }

  thumbnails {
    format         = "jpg"
    interval       = 10
    max_width      = "1280"
    max_height     = "720"
    padding_policy = "NoPad"
    sizing_policy  = "Stretch"
  }

}

resource "aws_elastictranscoder_pipeline" "magicvideos_pipeline" {
  name         = "magicvideos_pipeline"
  input_bucket = aws_s3_bucket.magicvideos_bucket.bucket
  role         = aws_iam_role.magicvideos_role.arn

  aws_kms_key_arn = aws_kms_key.magicvideos_kms_key.arn

  content_config {
    bucket        = aws_s3_bucket.magicvideos_bucket.bucket
    storage_class = "Standard"
  }

  thumbnail_config {
    bucket        = aws_s3_bucket.magicvideos_bucket.bucket
    storage_class = "Standard"
  }

}
