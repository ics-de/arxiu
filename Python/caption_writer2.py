import speech_recognition as sr
import time

r = sr.Recognizer()

captionsPath = "C:/Postgrau/Treball Final/arxiu/Processing/arxiu_SpeechToTapestry/data/captions.txt"

print("Starting real-time captioning... Press Ctrl+C to stop.")

with sr.Microphone() as source:
    r.adjust_for_ambient_noise(source)
    print("Microphone calibrated.")

    while True:
        try:
            print("Listening...")
            # Automatically listens when voice starts, for max 7s per phrase
            audio_data = r.listen(source, phrase_time_limit=7)
            print("Recognizing...")
            text = r.recognize_google(audio_data, language="ca-CA")
            print("Recognized:", text)

            with open(captionsPath, "a", encoding="utf-8") as f:
                f.write(f"{text}\n")

        except sr.WaitTimeoutError:
            print("No speech detected.")
        except sr.UnknownValueError:
            print("Could not understand audio.")
        except sr.RequestError as e:
            print(f"Could not request results: {e}")
        except KeyboardInterrupt:
            print("\nStopping transcription.")
            break
