import speech_recognition as sr
import time

r = sr.Recognizer()

captionsPath = "C:/Postgrau/Treball Final/arxiu/Processing/arxiu_SpeechToTapestry/data/captions.txt"

print("Starting real-time captioning...")

while True:
    with sr.Microphone() as source:
        r.adjust_for_ambient_noise(source)
        print("Listening...")
        audio_data = r.record(source, duration=5)
        print("Recognizing...")
        try:
            text = r.recognize_google(audio_data, language="ca-CA")
            print("Recognized:", text)
            with open(captionsPath, "a", encoding="utf-8") as f:
                #f.write(f"[{time.strftime('%H:%M:%S')}] {text}\n")
                f.write(f"{text}\n")
        except:
            print("Could not understand or connect.")

#Ctrl C in console to STOP