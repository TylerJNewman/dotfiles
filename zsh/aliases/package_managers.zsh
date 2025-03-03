# NPM aliases
alias ni="npm install"
alias nrs="npm run start -s --"
alias nrb="npm run build -s --"
alias nrd="npm run dev -s --"
alias nrt="npm run test -s --"
alias nrtw="npm run test:watch -s --"
alias nrv="npm run validate -s --"
alias rmn="rm -rf node_modules"
alias flush-npm="rm -rf node_modules package-lock.json && npm i && say NPM is done"
alias nicache="npm install --prefer-offline"
alias nioff="npm install --offline"
alias npm-update="npx ncu --dep prod,dev --upgrade"

# Yarn aliases
alias yar="yarn run"
alias yas="yarn run start"
alias yad="yarn run dev"
alias yab="yarn run build"
alias ybs="yarn build && yarn start"
alias yat="yarn run test"
alias yav="yarn run validate"
alias yoff="yarn add --offline"
alias ypm="echo \"Installing deps without lockfile and ignoring engines\" && yarn install --no-lockfile --ignore-engines"
alias yws="yarn workspace"
alias ywss="yarn workspaces"
alias yarn-update="yarn upgrade-interactive --latest"

# Note: PNPM aliases have been moved to zsh/aliases/pnpm.zsh
# Note: Project-specific aliases have been moved to zsh/aliases/pnpm.zsh