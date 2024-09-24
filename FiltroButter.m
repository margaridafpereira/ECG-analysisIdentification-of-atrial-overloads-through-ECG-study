function H_Butter = FiltroButter(Fs, fc, NFFT, n, tipo, inf, sup)
  
  wn = fc/(Fs/2);
  w = 0 : 2*pi/NFFT: 2*pi - 2*pi/NFFT;
  z = exp(1i*w);
  num = 1; 
  den = 1; 
  
  if (tipo == 'baixo')
    [zero,p,k] = butter(n,wn);
    for i = 1:n
      num = (z-zero(i)).*num;
      den = (z-p(i)).*den;
    end
    H_Butter = (num./den).*k; 
  endif
  
  if (tipo == 'stopp')
    [zero,p,k] = butter(n,[inf sup], 'stop');
    for i = 1:2.*n
      num = (z-zero(i)).*num;
      den = (z-p(i)).*den;
    endfor
    H_Butter = (num./den).*k; 
  endif
  
  if (tipo == 'altoo')
    [zero,p,k] = butter(n,(fc./(Fs./2)), 'high');
    for i = 1:n
      num = (z-zero(i)).*num;
      den = (z-p(i)).*den;
    endfor
    H_Butter = (num./den).*k; 
  endif
  
  if (tipo == 'passa')
    [zero,p,k] = butter(n,([inf sup]./(Fs./2)));
    for i = 1:2.*n
      num = (z-zero(i)).*num;
      den = (z-p(i)).*den;
    endfor
    H_Butter = (num./den).*k; 
  endif
end