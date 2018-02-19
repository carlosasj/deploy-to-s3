# Deploy to S3

This image contains a script to replace all the content of a certain AWS S3 Bucket with a folder you specify.

### Motivation

To facilitate the script to deploy some Single Page Application built on CI/CD services to AWS S3

### How to use

#### Docker Compose

Create a dockerfile with this content:

```yml
version: '2'
services:
  deploy:
    image: carlosaschjr/deploy-to-s3
    environment:
      AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
      AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
      AWS_DEFAULT_REGION: ${AWS_DEFAULT_REGION}
      AWS_S3_BUCKET: bucket_to_replace_content
    volumes:
      - './path/to/your/compiled/project:/project/dist'
```

##### Deploying

In case you're usig Host Environment Variables inside your `docker-compose.yml` (like the example above), ensure that you have exported the key/secret/region variable:

```bash
export AWS_ACCESS_KEY_ID="<id>"
export AWS_SECRET_ACCESS_KEY="<key>"
export AWS_DEFAULT_REGION="<region>"
```

Then just type `docker-compose run deploy` and the Bucket content will be replaced.

#### (pure) Docker command line

```bash
docker run -it --rm \
    -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
    -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
    -e "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}" \
    -e "AWS_S3_BUCKET=bucket_to_replace_content" \
    -v "/path/to/your/compiled/project:/project/dist" \
    carlosaschjr/deploy-to-s3
```

### Details

##### Environments

- `AWS_ACCESS_KEY_ID`: The access_key_id you get to your account on AWS IAM. [1]
- `AWS_SECRET_ACCESS_KEY`: The secret_access_key you get to your account on AWS IAM. [1]
- `AWS_DEFAULT_REGION`: The region of the S3 bucket
- `AWS_S3_BUCKET`: The name of the S3 bucket (the bucket must exist)

[1] It is a good practice to **not** commit this key/secret in plain text to your code repository. Preferably you should put this value as a Environment Variable on your host machine (or on the CI/CD service).

##### Volumes

You should map the folder of your compiled project (e.g. `dist` for default `angular-cli` projects) to `/project/dist`.
