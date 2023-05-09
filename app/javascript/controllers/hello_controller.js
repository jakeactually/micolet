import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preferences"];

  update_prefs() {
    const checked = document.querySelectorAll('.preference [type="checkbox"]:checked');
    this.preferencesTarget.value = [...checked].map(x => x.id.split('_')[1]).join();
  }
}
