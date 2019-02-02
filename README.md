# out-of-box-hexo-server

A web server in docker, with auto-configured ssh service.  
Just deploy your hexo blog with `hexo-deloyer-sftp` without many configures.

## Quick Start

### Start a static web server without HTTPS

1. Startup `out-of-box-hexo-server` on your server.

   ```bash
   mkdir key
   docker run -v $(pwd)/key:/key -p 80:80 -p 10022:22 -d strrl/out-of-box-hexo-server
   ```

   Then you will get this:

   ```text
   .
   └── key
       ├── hexo.key
       └── hexo.key.pub
   ```

1. Download `hexo.key` to your PC.

1. Config `deploy` in hexo config file `_config.yml`, like:

    ```yaml
    deploy:
      type: sftp
      host: your host domain or ip address
      user: root # dont change this
      remotePath: /data # dont change this
      port: 10022
      privateKey: path/to/your/hexo.key
    ```

1. Execute `hexo g && hexo d`

### With HTTPS

If you want to use HTTPS on your blog, you should prepare your certification file and private key file by your self.

1. Prepare certification and private key.
   Make a new directory, put your certification and private key in there. Rename certification to `cert.cer`, private key to `cert.key`.

   You will get this:

   ```text
   .
   └── cert
       ├── cert.cer
       └── cert.key
   ```

2. Startup the server:

   ```bash
   mkdir key
   docker run -v $(pwd)/key:/key -v $(pwd)/cert:/cert -p 80:80 -p 443:443 -p 10022:22 -d strrl/out-of-box-hexo-server
   ```

   Your file should like this:

   ```text
    .
    ├── cert
    │   ├── cert.cer
    │   └── cert.key
    └── key
        ├── hexo.key
        └── hexo.key.pub
   ```

3. Do the same thing just like normal.

## TODO List

- [x] Nginx docker image with openssh.
- [x] Automatic generate ssh private key.
- [ ] Test with `hexo-deloyer-sftp`.
- [ ] Add some arguments such as private key passphrase.
- [x] SSL config
