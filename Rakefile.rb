task :default do
  system( 'grunt build' )
  system( 'npm test' )
end