# Hexo docker, docker-compose 部署

### Setting SSH Keys

```sh
# docker exec into container
docker exec -it <container_name> sh

ssh-keygen -t rsa -C "userName@address"
# or
ssh-keygen -t rsa -f ~/.ssh/id_rsa -C "userName@address"

cd ~/.ssh
```

In container's create `~/.ssh/config` or touch `./ssh/config` in local
~/.ssh/config:
```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa

Host gitea.fuweilab.com
    HostName gitea.fuweilab.com
    User git
    IdentityFile ~/.ssh/id_rsa_gitea_fuweilab

```

Test ssh
```
ssh -T git@<Host>
```

---
### Reference
hexo:
[如何使用 Docker 打造 Hexo 開發環境 ?](https://oomusou.io/docker/hexo/development/)
[oomusou/hexo-suka github](https://github.com/oomusou/hexo-suka)
[docker实现hexo博客自动部署，实时更新](https://www.tapme.top/blog/detail/2019-03-03-15-42/)
[FleyX/hexoBlog github](https://github.com/FleyX/hexoBlog)
[docker-library/ghost](https://github.com/docker-library/ghost)

[如何在 GitHub 上架一個 Hexo 部落格](https://alxtz.github.io/2018/07/15/hexo-on-github/)
[Hexo常见问题解决方案](https://xuanwo.io/2014/08/14/hexo-usual-problem/)
[使用Github SSH Key以免去Hexo部署时输入密码](https://xuanwo.io/2015/02/07/generate-a-ssh-key/)


ssh:
[ssh配置-使用本地多个私钥连接多个账户的github rsa认证](https://blog.csdn.net/Dong_Alex/article/details/80813816)
[如何在一台電腦使用多個Git帳號](https://medium.com/@hyWang/如何在一台電腦使用多個git帳號-907c8eadbabf)
[多重 SSH Keys 與 Github 帳號](https://kuanyui.github.io/2016/08/01/git-multiple-ssh-key/)
[How to setup SSH config ：使用 SSH 設定檔簡化指令與連線網址](https://medium.com/浦島太郎的水族缸/how-to-setup-ssh-config-使用-ssh-設定檔-74ad46f99818)
[SSH Config 那些你所知道和不知道的事](https://deepzz.com/post/how-to-setup-ssh-config.html)
