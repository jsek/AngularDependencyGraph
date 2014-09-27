task :default do
  system( 'coffee -bc .' )
  system( 'npm test' )
end