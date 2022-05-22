function P = rrc(t,alpha,T)
%
% returns the Root-Raised Cosine with roll-off factor alpha and symbol
% period T at the times given in t
% 

% t(t==0) = eps; % T/1e5; % gets rid of t==0, which is not defined
P = zeros(size(t));
P(t~=0) = 4*alpha/(pi*sqrt(T)) * ( cos((1+alpha)*pi*t(t~=0)/T) +...
    sin((1-alpha)*pi*t(t~=0)/T)./(4*alpha*t(t~=0)/T) ) ./...
    (1 - (4*alpha*t(t~=0)/T).^2);
P(t==0) = (pi+alpha*(4-pi))/(pi*sqrt(T));
P((t==T/4/alpha)|(t==-T/4/alpha)) = (alpha/sqrt(2*T))*...
    ((1+2/pi)*sin(pi/4/alpha) + (1-2/pi)*cos(pi/4/alpha));