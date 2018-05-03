import Test from 'test';

test('there is no I2 in team', () => {
  expect('team').not.toMatch(/I2/);
});
