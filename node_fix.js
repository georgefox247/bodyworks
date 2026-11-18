const { exec } = require('child_process');

exec('cd D:\\AI\\github.co-uk && Remove-Item "pages\\_config.yml" -Force', function(err, stdout, stderr) {
  if (err) {
    console.error('ERROR:', err.message);
    console.log('Stderr:', stderr);
  } else {
    console.log('File removed successfully');
    console.log(stdout);
  }
});
