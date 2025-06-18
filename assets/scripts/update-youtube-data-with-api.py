import os
import time
import pandas as pd
from dotenv import load_dotenv
from googleapiclient.discovery import build

# Load API key from .env file
load_dotenv()
API_KEY = os.getenv("YOUTUBE_API_KEY")

if not API_KEY:
    raise ValueError(" API key not found in .env file")

# Build YouTube API client (no auth needed, just API key)
youtube = build('youtube', 'v3', developerKey=API_KEY, static_discovery=False)

# Function to get channel stats
def get_channel_stats(channel_id):
    try:
        request = youtube.channels().list(
            part="snippet,statistics",
            id=channel_id
        )
        response = request.execute()
        items = response.get("items", [])

        if not items:
            print(f"Channel not found: {channel_id}")
            return None

        item = items[0]
        return {
            "channel_id": channel_id,
            "channel_name": item["snippet"]["title"],
            "subscribers": item["statistics"].get("subscriberCount", 0),
            "views": item["statistics"].get("viewCount", 0),
            "videos": item["statistics"].get("videoCount", 0)
        }
    except Exception as e:
        print(f"Error for {channel_id}: {e}")
        return None

# Update this path to actual file
csv_path = r"D:\sql\youtube\united-kingdom\youtube_data_united-kingdom.csv"


# Read CSV and extract channel IDs
df = pd.read_csv(csv_path)

# Get channel IDs from '@' handles
channel_ids = df['NOMBRE'].str.split('@').str[-1].dropna().unique()

# Collect stats
channel_data = []

for cid in channel_ids:
    data = get_channel_stats(cid)
    if data:
        channel_data.append(data)
    time.sleep(0.2)  # avoid rate limits

# Convert to DataFrame
stats_df = pd.DataFrame(channel_data)

# Merge original + stats
df.reset_index(drop=True, inplace=True)
stats_df.reset_index(drop=True, inplace=True)

final_df = pd.concat([df, stats_df], axis=1)

# Save result
final_df.to_csv("updated_youtube_data.csv", index=False)
print("Data saved to 'updated_youtube_data.csv'")

# Show sample
print(final_df.head(10))
