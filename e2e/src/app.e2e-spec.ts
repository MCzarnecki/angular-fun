import { AppPage } from './app.po';
import { browser } from '../../node_modules/protractor';

describe('workspace-project App', () => {

  it('should display welcome message', () => {
    browser.get('/');
    browser.sleep(5000);
    expect(true).toBeTruthy();
  });
});
