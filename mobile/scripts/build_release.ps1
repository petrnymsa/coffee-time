flutter build appbundle
rm ./build/app/outputs/apk -r -fo
java -jar D:\tools\bundletool.jar build-apks --bundle=./build/app/outputs/bundle/release/app-release.aab --output=./build/app/outputs/apk/release.apks --ks=C:\\Users\\nymsa\\key.jks --ks-pass=pass:farmick96as --ks-key-alias=key --key-pass=pass:farmick96as