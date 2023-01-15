#!/bin/bash

cd server-smc-dart
dart --no-sound-null-safety bin/server.dart 1> ../smc.log &
