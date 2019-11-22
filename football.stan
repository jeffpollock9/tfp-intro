data {
    int<lower = 1> num_data;
    int<lower = 2> num_teams;
    int<lower = 1, upper = num_teams> home_team[num_data];
    int<lower = 1, upper = num_teams> away_team[num_data];
    int<lower = 0> home_goals[num_data];
    int<lower = 0> away_goals[num_data];
}

parameters {
    real intercept;
    real home_advantage;
    real<lower = 0.0> team_scale;
    vector[num_teams] attack;
    vector[num_teams] defence;
}

model {
    vector[num_data] home_log_rate = intercept +
        home_advantage +
        attack[home_team] +
        defence[away_team];

    vector[num_data] away_log_rate = intercept +
        attack[away_team] +
        defence[home_team];

    intercept ~ std_normal();
    home_advantage ~ std_normal();
    team_scale ~ exponential(1.0);

    attack ~ normal(0.0, team_scale);
    defence ~ normal(0.0, team_scale);

    home_goals ~ poisson_log(home_log_rate);
    away_goals ~ poisson_log(away_log_rate);
}