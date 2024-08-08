#include "../include/generator.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define DEVICE_FORMAT ma_format_f32
#define DEVICE_CHANNELS 2
#define DEVICE_SAMPLE_RATE 48000

ma_waveform waveform;
ma_pulsewave pulsewave;
ma_noise noise;
ma_device device;
ma_device_config deviceConfig;
ma_waveform_config sineWaveConfig;

Generator *generator_create(void)
{
    Generator *generator = (Generator *)malloc(sizeof(Generator));
    if (generator == NULL)
    {
        printf("Error: Failed to allocate memory for Generator.\n");
        return NULL;
    }
    memset(generator, 0, sizeof(Generator));
    printf("Debug: Generator created successfully.\n");
    return generator;
}

void generator_destroy(Generator *generator)
{
    if (generator != NULL)
    {
        ma_waveform_uninit(&waveform);
        ma_pulsewave_uninit(&pulsewave);
        ma_noise_uninit(&noise, NULL);
        circular_buffer_uninit(&generator->circular_buffer);
        free(generator);
        printf("Debug: Generator destroyed successfully.\n");
    }
}

void data_callback(ma_device *pDevice, void *pOutput, const void *pInput, ma_uint32 frameCount)
{
    Generator *generator;
    generator = (Generator *)pDevice->pUserData;

    circular_buffer_write(&generator->circular_buffer, pOutput, frameCount * generator->channels);

    switch (generator->type)
    {
    case GENERATOR_TYPE_WAVEFORM:
        ma_waveform_read_pcm_frames(&waveform, pOutput, frameCount, NULL);
        break;
    case GENERATOR_TYPE_PULSEWAVE:
        ma_pulsewave_read_pcm_frames(&pulsewave, pOutput, frameCount, NULL);
        break;
    case GENERATOR_TYPE_NOISE:
        ma_noise_read_pcm_frames(&noise, pOutput, frameCount, NULL);
        break;
    default:
        printf("Warning: Unknown generator type in data_callback.\n");
        break;
    }

    (void)pInput;
}

GeneratorResult generator_init(Generator *generator, ma_format format, int channels, int sample_rate, int buffer_duration_seconds)
{
    generator_set_noise(generator, ma_noise_type_white, 0, 0.5);
    generator_set_pulsewave(generator, 440.0, 0.5, 0.5);
    generator_set_waveform(generator, ma_waveform_type_sine, 440.0, 0.5);

    deviceConfig = ma_device_config_init(ma_device_type_playback);
    deviceConfig.playback.format = format;
    deviceConfig.playback.channels = channels;
    deviceConfig.sampleRate = sample_rate;
    deviceConfig.dataCallback = data_callback;
    deviceConfig.pUserData = generator;

    if (ma_device_init(NULL, &deviceConfig, &device) != MA_SUCCESS)
    {
        printf("Failed to open playback device.\n");
        return -4;
    }
    if (generator == NULL)
    {
        printf("Error: Generator is NULL in generator_init.\n");
        return GENERATOR_ERROR;
    }
    if (buffer_duration_seconds <= 0 || sample_rate <= 0 || channels <= 0)
    {
        printf("Error: Invalid parameters in generator_init. Buffer duration: %d, Sample rate: %u, Channels: %u\n",
               buffer_duration_seconds, sample_rate, channels);
        return GENERATOR_ERROR;
    }

    printf("Debug: Initializing generator with format: %d, channels: %u, sample rate: %u, buffer duration: %d seconds\n",
           format, channels, sample_rate, buffer_duration_seconds);

    generator->sample_rate = sample_rate;
    generator->channels = channels;

    printf("Debug: Audio device initialized.\n name: %s\n", device.playback.name);

    size_t buffer_size_in_bytes = (size_t)(sample_rate * channels * ma_get_bytes_per_sample(format) * buffer_duration_seconds);
    if (circular_buffer_init(&generator->circular_buffer, buffer_size_in_bytes) != 0)
    {
        printf("Error: Failed to initialize circular buffer.\n");
        ma_device_uninit(&device);
        return GENERATOR_ERROR;
    }

    printf("Debug: Generator initialized successfully.\n");
    return GENERATOR_OK;
}

GeneratorResult generator_set_waveform(Generator *generator, ma_waveform_type type, double frequency, double amplitude)
{
    if (generator == NULL)
    {
        printf("Error: Generator is NULL in generator_set_waveform.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Setting waveform with type: %d, frequency: %f, amplitude: %f\n", type, frequency, amplitude);

    generator->type = GENERATOR_TYPE_WAVEFORM;

    ma_waveform_config config = ma_waveform_config_init(device.playback.format, device.playback.channels, device.sampleRate, type, amplitude, frequency);
    if (ma_waveform_init(&config, &waveform) != MA_SUCCESS)
    {
        printf("Error: Failed to initialize waveform.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Waveform set successfully.\n");
    return GENERATOR_OK;
}

GeneratorResult generator_set_pulsewave(Generator *generator, double frequency, double amplitude, double dutyCycle)
{
    if (generator == NULL)
    {
        printf("Error: Generator is NULL in generator_set_pulsewave.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Setting pulsewave with frequency: %f, amplitude: %f, duty cycle: %f\n", frequency, amplitude, dutyCycle);

    generator->type = GENERATOR_TYPE_PULSEWAVE;

    ma_pulsewave_config config = ma_pulsewave_config_init(ma_format_f32, generator->channels, generator->sample_rate, dutyCycle, amplitude, frequency);
    if (ma_pulsewave_init(&config, &pulsewave) != MA_SUCCESS)
    {
        printf("Error: Failed to initialize pulsewave.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Pulsewave set successfully.\n");
    return GENERATOR_OK;
}

GeneratorResult generator_set_noise(Generator *generator, ma_noise_type type, ma_int32 seed, double amplitude)
{
    if (generator == NULL)
    {
        printf("Error: Generator is NULL in generator_set_noise.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Setting noise with type: %d, seed: %d, amplitude: %f\n", type, seed, amplitude);

    generator->type = GENERATOR_TYPE_NOISE;

    ma_noise_config config = ma_noise_config_init(ma_format_f32, generator->channels, type, seed, amplitude);
    if (ma_noise_init(&config, NULL, &noise) != MA_SUCCESS)
    {
        printf("Error: Failed to initialize noise.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Noise set successfully.\n");
    return GENERATOR_OK;
}

GeneratorResult generator_start(Generator *generator)
{
    if (generator == NULL)
    {
        printf("Error: Generator is NULL in generator_start.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Starting generator.\n");
    if (ma_device_start(&device) != MA_SUCCESS)
    {
        printf("Error: Failed to start generator.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Generator started successfully.\n");
    return GENERATOR_OK;
}

GeneratorResult generator_stop(Generator *generator)
{
    if (generator == NULL)
    {
        printf("Error: Generator is NULL in generator_stop.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Stopping generator.\n");

    if (ma_device_stop(&device) != MA_SUCCESS)
    {
        printf("Error: Failed to stop generator.\n");
        return GENERATOR_ERROR;
    }

    printf("Debug: Generator stopped successfully.\n");
    return GENERATOR_OK;
}

int generator_get_buffer(Generator *generator, float *output, int floats_to_read)
{
    if (generator == NULL || output == NULL || floats_to_read <= 0)
    {
        printf("Error: Invalid parameters in generator_get_buffer. Generator: %p, Output: %p, Frames to read: %u\n",
               generator, output, floats_to_read);
        return 0;
    }

    size_t available_floats = circular_buffer_get_available_floats(&generator->circular_buffer);
    size_t to_read = (floats_to_read < available_floats) ? floats_to_read : available_floats;

    return (int)circular_buffer_read(&generator->circular_buffer, output, to_read);
}

int generator_get_available_frames(Generator *generator)
{
    if (generator == NULL)
    {
        printf("Error: Generator is NULL in generator_get_available_frames.\n");
        return 0;
    }

    size_t available_floats = circular_buffer_get_available_floats(&generator->circular_buffer);
    return (int)(available_floats / generator->channels);
}
