data {
    real observation;
    real covariate;
}

parameters {
    real coefficient;
    real<lower = 0.0> observation_noise_scale;
}

model {
    coefficient ~ normal(0.0, 1.0);
    observation_noise_scale ~ exponential(1.0);
    observation ~ normal(coefficient * covariate, observation_noise_scale);
}
