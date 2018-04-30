import Test from 'app';

test('there is no I2 in team', () => {
  expect('team').not.toMatch(/I2/);
});
