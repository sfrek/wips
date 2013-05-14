```ruby
root@moya ~ # cat vmblkdevices.rb 
require "rexml/document"

if ARGV.length != 1
    puts "Error de argumentos"
    exit(1)
end

file = ARGV[0]

if not File.exists?(file)
    puts "Fichero #{file} No existe"
    exit(2)
end

xml = REXML::Document.new(File.new(file))

xml.root.elements.each("*/disk/source") do |element| 
    puts element.attributes["file"]
end
```

```
root@moya ~ # for D in $(virsh -q list --all | awk '/precise.OpenStack/ {print $2}');do ruby vmblkdevices.rb /etc/libvirt/qemu/${D}.xml | xargs rm -v ;virsh undefine $D;done
removed `/var/lib/libvirt/images/precise.OpenStack.C01.img'
Domain precise.OpenStack.C01 has been undefined

removed `/var/lib/libvirt/images/precise.OpenStack.C02.img'
Domain precise.OpenStack.C02 has been undefined

removed `/var/lib/libvirt/images/precise.OpenStack.C03.img'
Domain precise.OpenStack.C03 has been undefined

removed `/var/lib/libvirt/images/precise.OpenStack.CC1.img'
removed `/var/lib/libvirt/images/precise.OpenStack.cinder.img'
removed `/var/lib/libvirt/images/precise.OpenStack.glance.img'
Domain precise.OpenStack.CC1 has been undefined

removed `/var/lib/libvirt/images/precise.OpenStack.KVM01.img'
Domain precise.OpenStack.KVM01 has been undefined

removed `/var/lib/libvirt/images/precise.OpenStack.KVM02.img'
Domain precise.OpenStack.KVM02 has been undefined

removed `/var/lib/libvirt/images/precise.OpenStack.NT.img'
Domain precise.OpenStack.NT has been undefined

```
