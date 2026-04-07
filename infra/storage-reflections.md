# Storage Reflections



## Explain how your app allows users to upload and view photos in your S3 bucket despite the fact that objects in S3 buckets are private by default and you did NOT apply any policies that would override that

The S3 bucket is set to private by default, which means users cannot access the images directly. Instead of making the bucket public, the app generates pre-signed URLs when it needs to show an image. A pre-signed URL is a temporary link that allows access to a specific file in the S3 bucket. The app server creates this URL using its AWS credentials and gives it to the user. This allows the image to be viewed without making the whole bucket public. The app controls who gets the URL, and the URL expires after a certain amount of time


## Explain why the two GSIs you created are useful, and why the specific attributes used for the has and range keys are the right choices for those GSIs.

## 2. Explain why the two GSIs you created are useful, and why the specific attributes used for the hash and range keys are the right choices for those GSIs.

The two GSIs are useful because the app needs to get photos in two different ways.
The 'user-photos-index' is used to get all photos for a specific user. The hash key is 'user_id' because that is what identifies the user. The range key is 'uploaded_at' so the photos can be sorted by time, which lets the app show the most recent photos first on the profile page.
The 'feed-index' is used for the public feed. The hash key is 'feed_key' because only photos marked as public should appear in the feed. The range key is 'uploaded_at' so the feed can show the newest photos first.

These keys are the right choice because they match exactly how the app needs to query and display the data.