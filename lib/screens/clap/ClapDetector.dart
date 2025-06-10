import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class ClapDetector extends StatefulWidget {
  @override
  _ClapDetectorState createState() => _ClapDetectorState();
}

class _ClapDetectorState extends State<ClapDetector> {
  FlutterSoundRecorder? _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool _isCalibrating = false;
  int _clapCount = 0;
  double _clapThreshold = 20000; // Initial value, will be calibrated
  double _backgroundNoiseLevel = 0; // To store average noise level
  StreamSubscription? _recorderSubscription;
  StreamController<Uint8List>? _pcmStreamController;
  bool _isClapDetected = false; // For debouncing
  double _maxAmplitude = 0; // Track max amplitude for debugging
  List<double> _amplitudeBuffer = []; // Buffer for noise calibration

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _recorder!.openRecorder();
    _recorder!.setSubscriptionDuration(Duration(milliseconds: 10));
  }

  // Calibrate background noise level
  Future<void> _calibrateThreshold() async {
    setState(() {
      _isCalibrating = true;
      _amplitudeBuffer.clear();
    });
    log("Calibrating background noise... Please keep the environment quiet for 5 seconds.");

    // Collect amplitude data for 5 seconds
    Timer(Duration(seconds: 5), () {
      if (_amplitudeBuffer.isNotEmpty) {
        double averageNoise = _amplitudeBuffer.reduce((a, b) => a + b) / _amplitudeBuffer.length;
        setState(() {
          _backgroundNoiseLevel = averageNoise;
          _clapThreshold = averageNoise * 3; // Set threshold to 3x background noise
          _isCalibrating = false;
        });
        log("Calibration complete. Background noise: $_backgroundNoiseLevel, New threshold: $_clapThreshold");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Calibration complete! Threshold set to ${_clapThreshold.toStringAsFixed(2)}")),
        );
      } else {
        log("No data collected during calibration");
        setState(() {
          _isCalibrating = false;
        });
      }
    });
  }

  Future<void> _startRecording() async {
    if (!_isRecording) {
      _pcmStreamController = StreamController<Uint8List>();

      try {
        await _recorder!.startRecorder(
          codec: Codec.pcm16,
          sampleRate: 16000,
          numChannels: 1,
          toStream: _pcmStreamController!.sink,
        );
      } catch (e) {
        log("Error starting recorder: $e");
        return;
      }

      _recorderSubscription = _pcmStreamController!.stream.listen((buffer) {
        if (buffer != null && buffer.isNotEmpty) {
          double currentMaxAmplitude = 0;
          for (int i = 0; i < buffer.length - 1; i += 2) {
            // Convert bytes to 16-bit PCM sample
            int sample = buffer[i] | (buffer[i + 1] << 8);
            if (sample > 32767) sample -= 65536; // Handle signed 16-bit
            double amplitude = sample.abs().toDouble();

            // Simple high-pass filter: ignore low-frequency noise
            if (i > 0) {
              double prevSample = (buffer[i - 2] | (buffer[i - 1] << 8)).toDouble();
              if (prevSample > 32767) prevSample -= 65536;
              amplitude = (amplitude - 0.5 * prevSample).abs(); // Basic high-pass
            }

            currentMaxAmplitude = amplitude > currentMaxAmplitude ? amplitude : currentMaxAmplitude;

            // Collect amplitude for calibration
            if (_isCalibrating) {
              _amplitudeBuffer.add(amplitude);
            }

            // Detect clap if amplitude exceeds threshold and not recently detected
            if (amplitude > _clapThreshold && !_isClapDetected && !_isCalibrating) {
              setState(() {
                _clapCount++;
                _isClapDetected = true;
              });
              log("Clap detected! Count: $_clapCount, Amplitude: $amplitude, Threshold: $_clapThreshold");
              // Debounce for 500ms
              Future.delayed(Duration(milliseconds: 500), () {
                _isClapDetected = false;
              });
              break;
            }
          }
          // Update max amplitude for debugging
          if (currentMaxAmplitude > _maxAmplitude) {
            setState(() {
              _maxAmplitude = currentMaxAmplitude;
            });
          }
          log("Max amplitude in buffer: $currentMaxAmplitude");
        } else {
          log("Empty or null buffer received");
        }
      }, onError: (e) {
        log("Stream error: $e");
      }, onDone: () {
        log("Stream closed");
      });

      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stopRecording() async {
    if (_isRecording) {
      await _recorderSubscription?.cancel();
      await _pcmStreamController?.close();
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
        _isClapDetected = false;
        _isCalibrating = false;
      });
    }
  }

  @override
  void dispose() {
    _recorderSubscription?.cancel();
    _pcmStreamController?.close();
    _recorder!.closeRecorder();
    _recorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clap Detector')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Claps Detected: $_clapCount'),
            Text('Max Amplitude: ${_maxAmplitude.toStringAsFixed(2)}'),
            Text('Background Noise: ${_backgroundNoiseLevel.toStringAsFixed(2)}'),
            Text('Threshold: ${_clapThreshold.toStringAsFixed(2)}'),
            Text(_isCalibrating ? 'Calibrating...' : 'Ready'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            ElevatedButton(
              onPressed: _isRecording && !_isCalibrating ? _calibrateThreshold : null,
              child: Text('Calibrate Threshold'),
            ),
          ],
        ),
      ),
    );
  }
}