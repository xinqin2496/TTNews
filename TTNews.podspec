Pod::Spec.new do |s|
  s.name         = 'TTNews'
  s.version      = '<#Project Version#>'
  s.license      = '<#License#>'
  s.homepage     = '<#Homepage URL#>'
  s.authors      = '<#Author Name#>': '<#Author Email#>'
  s.summary      = '<#Summary (Up to 140 characters#>'

  s.platform     =  :ios, '<#iOS Platform#>'
  s.source       =  git: '<#Github Repo URL#>', :tag => s.version
  s.source_files = '<#Resources#>'
  s.frameworks   =  '<#Required Frameworks#>'
  s.requires_arc = true
  
# Pod Dependencies
  s.dependencies =	pod 'MJRefresh'
  s.dependencies =	pod 'MJExtension'
  s.dependencies =	pod 'AFNetworking'
  s.dependencies =	pod 'SDWebImage'
  s.dependencies =	pod 'pop'
  s.dependencies =	pod 'MBProgressHUD'
  s.dependencies =	pod 'DACircularProgress'
  s.dependencies =	pod 'FMDB'
  s.dependencies =	pod 'NJKWebViewProgress'
  s.dependencies =	pod 'BlocksKit'
  s.dependencies =	pod 'Masonry'
  s.dependencies =	pod 'UMengSocial'

end