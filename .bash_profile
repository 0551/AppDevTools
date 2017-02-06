alias subl="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"
export ANDROID_HOME=~/android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH=$HOME/bin:/usr/local/bin:$PATH
export CLICOLOR=1


# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/rcshop-onreact"
alias g="git"
alias h="history"
alias j="jobs"
alias rn="react-native run-android"
alias rnsrc="react-native bundle --platform android --dev false --entry-file index.android.js  --bundle-output android/app/src/main/assets/index.android.bundle  --assets-dest android/app/src/main/res/"
alias rndel="cd android && ./gradlew assembleRelease"
alias rnapk="cd app/build/outputs/apk/"
alias rnclean="cd android && ./gradlew clean"

# Edit ReactNative Gradle
alias rnand="subl android/build.gradle" # 2.2
alias rna="subl android/gradle/wrapper/gradle-wrapper.properties" # 1.2.3

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
