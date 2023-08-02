#!/bin/zsh

export API_KEY="f830e63ea6406ed08ad6b75e1071a86b"
export VOICE_ID="z9fAnlkpzviPz146aGWa"

curl -X 'POST' \
  --header 'accept: audio/mpeg' \
  --header 'xi-api-key: f830e63ea6406ed08ad6b75e1071a86b' \
  --header 'Content-Type: application/json' \
  --output test.mp3 \
  --data '{
    "text": "This is a test for Florida. Lets see how it goes.", 
    "model_id": "eleven_monolingual_v1", 
    "voice_settings": {
      "stability": 0.5,
      "similarity_boost": 0.5
    }
  }' \
'https://api.elevenlabs.io/v1/text-to-speech/z9fAnlkpzviPz146aGWa' 
